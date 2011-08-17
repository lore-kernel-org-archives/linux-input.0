From: Brian Foster <brian.foster@maxim-ic.com>
Subject: [Q] max11801 licensing terms
Date: Wed, 17 Aug 2011 14:31:26 +0200
Message-ID: <201108171431.26470.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from antispam01.maxim-ic.com ([205.153.101.182]:35242 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1HQMuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 08:50:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Jean-Marc Simohand <JeanMarc.Simohand@maxim-ic.com>

Zhang Jiejing,

 In =E2=80=9C[PATCH V2] input: add maxim max11801 resistance touchscree=
n
 controller driver=E2=80=9D (commit 4203306506ebe4eaaa84a2cbd7c1eb2fc01=
28faa),

    http://www.spinics.net/lists/linux-input/msg14881.html

 there is a licensing statement my colleagues and I
 do not understand:

     * Based on mcs5000_ts.c
     *
     * This program is free software; you can redistribute it and/or mo=
dify
     * it under the terms of the GNU General Public License as publishe=
d by
     * the Free Software Foundation; either version 2 of the License.
   ...
    MODULE_LICENSE("GPL");

 What does =E2=80=9Ceither version 2 of the License.=E2=80=9D mean?
 Either GPLv2 or what?
 The "GPL" MODULE_LICENSE implies what is meant is
 either GPLv2 or a later GPL version; please see
 =E2=80=98include/linux/module.h=E2=80=99:

     * The following license idents are currently accepted as indicatin=
g free
     * software modules
     *
     *      "GPL"                           [GNU Public License v2 or l=
ater]
     *      "GPL v2"                        [GNU Public License v2]

 The original statement in =E2=80=98mcs5000_ts.c=E2=80=99 (from Joonyou=
ng Shim,
 whom I've CC-ed) is the usual (reformatted to avoid long lines):

     * This program is free software; you can redistribute it and/or mo=
dify
     * it under the terms of the GNU General Public License as publishe=
d by
     * the Free Software Foundation; either version 2 of the License, o=
r (at
     * your option) any later version.

 Could you please clarify exactly what =E2=80=98max11801_ts.c=E2=80=99 =
licensing
 terms are?  Thanks!

cheers,
        -blf-
--=20
Brian FOSTER
Principal MTS, Software
Maxim Integrated Products (Microcontroller BU), formerly Innova Card
Web    : http://www.maxim-ic.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
