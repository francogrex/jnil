;;; -*- mode: lisp; package: jnil.ast -*-
;;; Copyright (c) 2004-2005 Tiago Maduro-Dias. All Rights Reserved.
;;;
;;; This code is free software; you can redistribute it and/or
;;; modify it under the terms of the version 2.1 of
;;; the GNU Lesser General Public License as published by 
;;; the Free Software Foundation, as clarified by the preamble
;;; found in license-llgpl.txt.
;;;
;;; This code is distributed in the hope that it will be useful,
;;; but without any warranty; without even the implied warranty of
;;; merchantability or fitness for a particular purpose. See the GNU
;;; Lesser General Public License for more details.
;;;
;;; Version 2.1 of the GNU Lesser General Public License is in the file 
;;; license-lgpl.txt that was distributed with this file.
;;; If it is not present, you can access it from
;;; http://www.gnu.org/copyleft/lesser.txt (until superseded by a newer
;;; version) or write to the Free Software Foundation, Inc., 59 Temple Place, 
;;; Suite 330, Boston, MA  02111-1307  USA
;;;
;;; $Id: qualified-name.lisp,v 1.1.1.1 2006/04/23 17:11:42 tdias Exp $
;;;
;;; Description: Definition of a mapping for the QualifiedName class, defined
;;; in Eclipse's JDT.
;;;
;;; -- start of qualified-name.lisp --

(in-package :jnil.ast)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; symbol definition ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(def-java-class (qualified-name "org.eclipse.jdt.core.dom.QualifiedName") (name)
  () () ())

;;; Java methods
(def-java-method (qualified-name-qualifier "getQualifier") (qualified-name))

(def-java-method (qualified-name-name "getName") (qualified-name))

;;; Lisp extensions
(defun qualified-name-p (obj)
  (typep obj 'qualified-name))

(defmethod type-specifier-p ((name qualified-name))
  (= (jcall "getKind" (jcall "resolveBinding" name))
     (jfield "org.eclipse.jdt.core.dom.IBinding" "TYPE")))

(defmethod qualifier-is-type-p ((name qualified-name))
  (= (jcall "getKind" (jcall "resolveBinding" (qualified-name-qualifier name)))
     (jfield "org.eclipse.jdt.core.dom.IBinding" "TYPE")))

(defmethod node-children ((node qualified-name))
  (list (qualified-name-qualifier node)
        (qualified-name-name node)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; symbols are exported here ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(qualified-name qualified-name-p qualified-name-qualifier
            qualified-name-name type-specifier-p qualifier-is-type-p) 'jnil.ast))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; other miscellaneous operations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; -- end of qualified-name.lisp --
