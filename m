From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: Input: atmel_mxt_ts - don't always download device config?
Date: Mon, 12 Jan 2015 10:04:06 +0000
Message-ID: <54B39C16.5040000@itdev.co.uk>
References: <54B398D3.7010803@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:58987 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbbALKEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2015 05:04:16 -0500
In-Reply-To: <54B398D3.7010803@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 12/01/15 09:50, Dirk Behme wrote:
> Hi Nick,
> 
> being new to the atmel_mxt_ts and starting to work with it, we wonder if
> it's really necessary to download the device config [1] at each driver
> start up?
> 
> I've been told that technically each device config download does mean the
> configuration data is flashed to the device. I.e. it's stored persistently,
> even at power loss.

To be entirely correct, the configuration isn't stored persistently in
NVRAM on the device until this command is sent:

mxt_update_crc(data, MXT_COMMAND_BACKUPNV, MXT_BACKUP_VALUE);

But in essence, you're right: we should avoid the operation of downloading
the config on every probe. There's two good reasons to do that (a) it
avoids wearing out the flash (b) the file parse, download, backup/reset
operation is time consuming during the probe sequence.

> This would mean that it would be sufficient to check for the device config
> already existing/flashed to the device. And only doing the download in case
> this isn't done already.
> 
> Is this understanding correct? What do you think?

We already do as you describe. There is a checksum on the device over the
config data. We check it in this bit of code:

+ if (data->config_crc == config_crc) {
+   dev_dbg(dev, "Config CRC 0x%06X: OK\n", config_crc);
+   ret = 0;
+   goto release;
+ }

If the CRC matches, then the device config is presumed already correct and
the download is skipped.

We do have to go through the process of requesting the firmware from
userspace on every boot. However, when we tried the alternative approach of
storing the correct CRC in platform data (rather than with the config data
in the OBP_RAW file) it lead to very confusing behaviour when they aren't
kept in sync properly.

HTH!

> [1]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/touchscreen/atmel_mxt_ts.c?id=50a77c658b80e7e3303e3bcec195b30e2b62d513
