From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ELAN060C to the ACPI table
Date: Tue, 7 Nov 2017 16:20:31 -0800
Message-ID: <20171108002031.puzefl77xpnbkvry@dtor-ws>
References: <20171107091254.16747-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:55607 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbdKHAUf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Nov 2017 19:20:35 -0500
Content-Disposition: inline
In-Reply-To: <20171107091254.16747-1-kai.heng.feng@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 07, 2017 at 04:12:54AM -0500, Kai-Heng Feng wrote:
> ELAN060C touchpad uses elan_i2c as its driver. It can be
> found on Lenovo ideapad 320-14AST.
> 
> BugLink: https://bugs.launchpad.net/bugs/1727544
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 6d6b092e2da9..d6135900da64 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1258,6 +1258,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0605", 0 },
>  	{ "ELAN0609", 0 },
>  	{ "ELAN060B", 0 },
> +	{ "ELAN060C", 0 },
>  	{ "ELAN0611", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
> -- 
> 2.14.1
> 

-- 
Dmitry
