From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/9] Implement sparse keymap library
Date: Thu, 03 Dec 2009 22:11:52 -0800
Message-ID: <20091204060701.28288.91430.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:58439 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbZLDGLt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 01:11:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>, Anisse Astier <anisse@astier.eu>

It seems that almost everty platform driver out there copied the keymap
implementation from wistron button driver... That's a lot of duplicated code
and I think it is high time we split it into a library module that can be
shared between all these drivers.

Changes since v1: added sparse_keymap_report_event() and
sparse_keymap_report_entry() to furger reduce code in the drivers.

Len, what would be the best way to merge this? The patches touch a few of
the platform drivers and I would like to get it done sooner than later
because teh patch converting EVIOCGKEYCODE and EVIOCSKEYCODE to use
unisgned int instead of signed int scancodes depends on it.

Thanks.

-- 
Dmitry

