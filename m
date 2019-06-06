From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: repost: input: keyboard: gpio-keys-polled: use input name from pdata
Date: Fri,  7 Jun 2019 00:43:08 +0200
Message-ID: <1559860989-7723-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

this patch had already been sent a while ago, and a discussion arised
about whether pdata support should be dropped in favour of of/acpi.

Unfortunately, the open problems - lack of proper of/acpi data and sane
ways to inject this data - remain (theoretically, could be done by writing
special fwnode backends, but that would be a whole project on its own)
and the discussion perished w/o any conclusion.

Until we have a complete and easily replacement for pdata, even for cases
where no oftree/acpi data is available and platform drivers need to be
instantiated directly, pdata structs still need to be maintained.

Therefore I'm resending this pretty trivial patch.


--mtx
