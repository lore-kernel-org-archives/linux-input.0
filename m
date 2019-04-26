From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: gpio-keys-polled improvements v2
Date: Fri, 26 Apr 2019 21:01:19 +0200
Message-ID: <1556305282-24148-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello folks,

here's v2 of my gpio-keys-polled queue.

changes v2:

* removed the change in mod_devicetable.h
  (MODULE_DEVICE_TABLE_OF macro)
* reworked the patch for building w/o oftree, so it works
  w/o the MODULE_DEVICE_TABLE_OF macro

have fun,

--mtx
