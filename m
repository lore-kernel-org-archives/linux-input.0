From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH] HID: add ThingM blink(1) USB LED support
Date: Mon, 21 Jan 2013 13:36:29 -0500 (EST)
Message-ID: <721702502.537216.1358793389745.JavaMail.root@mail.savoirfairelinux.com>
References: <1329559360.389477.1358788441066.JavaMail.root@mail.savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:58911 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3AUSgf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 13:36:35 -0500
In-Reply-To: <1329559360.389477.1358788441066.JavaMail.root@mail.savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I wrote:
> Should I keep the Kconfig macro CONFIG_BLINK1 or CONFIG_THINGM_BLINK1
> sounds better?

CONFIG_HID_THINGM_BLINK1 is definitely more explicit. Here's a link to the v2:
https://lkml.org/lkml/2013/1/21/435

Thanks,
Vivien
