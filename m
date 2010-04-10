From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 18:04:49 +0200
Message-ID: <1270915489.3869.12.camel@lovely>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:55406 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0DJP7o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 11:59:44 -0400
Received: by fxm23 with SMTP id 23so3384242fxm.21
        for <linux-input@vger.kernel.org>; Sat, 10 Apr 2010 08:59:42 -0700 (PDT)
In-Reply-To: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux@philmerk.de, chatty@enac.fr

Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
> Added support for the eGalax dual-touch panel, found on the Asus EeePC T101MT

> +static void egalax_remove(struct hid_device *hdev)
> +{
> +	hid_hw_stop(hdev);
> +	kfree(hid_get_drvdata(hdev));
> +	hid_set_drvdata(hdev, NULL);
> +}

Why not using hid_hw_stop() instead of hid_set_drvdata()?


