From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ELAN0608 to the ACPI table
Date: Mon, 14 Aug 2017 21:54:01 -0700
Message-ID: <20170815045401.GA38592@dtor-ws>
References: <20170810085352.795-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36958 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdHOEyE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Aug 2017 00:54:04 -0400
Content-Disposition: inline
In-Reply-To: <20170810085352.795-1-kai.heng.feng@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: ktalex.liao@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 10, 2017 at 04:53:52PM +0800, Kai-Heng Feng wrote:
> Similar to commit 722c5ac708b4f ("Input: elan_i2c - add ELAN0605 to the
> ACPI table"), ELAN0608 should be handled by elan_i2c.
> 
> This touchpad can be found in Lenovo ideapad 320-14IKB.
> 
> BugLink: https://bugs.launchpad.net/bugs/1708852
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 3b616cb7c67f..9fe3908d12d5 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1248,6 +1248,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0100", 0 },
>  	{ "ELAN0600", 0 },
>  	{ "ELAN0605", 0 },
> +	{ "ELAN0608", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.14.0
> 

-- 
Dmitry
