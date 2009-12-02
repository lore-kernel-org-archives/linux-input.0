From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/8] [RFC/RFT] Implement sparse keymap library
Date: Wed, 02 Dec 2009 01:24:02 -0800
Message-ID: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

It seems that almost everty platform driver out there copied the keymap
implementation from wistron button driver... That's a lot of duplicated code
and I think it is high time we split it into a library module that can be
shared between all these drivers.

The code is only compile-tested since I don't have boxes that would run these
drivers.

Thanks.

-- 
Dmitry
