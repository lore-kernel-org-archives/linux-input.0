Return-Path: <SRS0=QVpx=4X=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AF7C10F25
	for <linux-input@archiver.kernel.org>; Fri,  6 Mar 2020 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4038C20656
	for <linux-input@archiver.kernel.org>; Fri,  6 Mar 2020 19:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCNE6aHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFTvk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:51:40 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34556 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFTvk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2020 14:51:40 -0500
Received: by mail-pj1-f68.google.com with SMTP id gc16so1987340pjb.1;
        Fri, 06 Mar 2020 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6P5kPHf07Ale8pEsJ/RqXtKfroxZj1z7x2Wtc11kAA=;
        b=VCNE6aHZWA/Sj3h88/Qilkeq3pQ9QmC1Lg/AfeL6VjJ5IzF3zVNONFBfwWdCsswYxm
         c1TSGIUu2NuWqFdTGiR7fW3xYoN67vTnreMsBOd6f31p6NWJLXVT5u6uqNF4aV1NKfaP
         jSayAZCrVUf4Ub51ca4E7LeczP8cWK6pFtg2AHMXQNfAzOdfWj4JgY5A5yua8u85WWgD
         ryhj7dHFUxTqTzKU/rARZJuuXpXQ3gO2UljGg8nYZWUtAV+o6537HfpytPPgJVEUJyCf
         BQfT+0IM34KTvWP5gQtD0S96E5LYKsT7HIBf2SCITriu2xiOGmz2OGjQvZpuWqQZ7s1f
         JXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6P5kPHf07Ale8pEsJ/RqXtKfroxZj1z7x2Wtc11kAA=;
        b=TdrbdoK/qihpWhxSUcHOSElpf4uqW5uJh/4sS8/M9CHbO8gdtn/4eUion/2+hyrAoH
         oKXmgMLdnAfl0KvLFUk05OYjAhil1IWgz6lg6GcqDp+lcOMV5Qzr7fYCTZKjI/aK3DKB
         9ppO/ISmUkVDZYaDJOewBhALLjmdDdqSrGF/+j1LJs9qQ3lqNUM6DpPanw+sHbsl/kGO
         kjhDdeIUxb24noPOdPWPWjQGBcOlM+SAZOFb5FdX+pD/BsOiwXm9KpDmm63Vz629fjRB
         eQTfOm3lnWvUnriSyBrAlGqttMIbSmexw9AAS0xzg0c1r8VFY1L4kqIa01yropMgUteL
         anvA==
X-Gm-Message-State: ANhLgQ3arGzkfLiG4fG5nIKAtjV9dljBmS/2OLL/vHrMUR5Ufs3YHe/U
        KRaZkJqmIHzaKsLFwlSBSzs=
X-Google-Smtp-Source: ADFU+vvmXScorSVduhMswCeyrT2aiZLcWKmEbgdagLgxX25pUfYBIPpbqEiKiQZnxgTgx5AMl88W6Q==
X-Received: by 2002:a17:90a:26c2:: with SMTP id m60mr5064249pje.70.1583524299195;
        Fri, 06 Mar 2020 11:51:39 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id k16sm10626464pfh.127.2020.03.06.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:51:38 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:51:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jeffrey Lin <jeffrey.lin@rad-ic.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Input: raydium_i2c_ts - fix error codes in
 raydium_i2c_boot_trigger()
Message-ID: <20200306195136.GJ217608@dtor-ws>
References: <20200303101306.4potflz7na2nn3od@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303101306.4potflz7na2nn3od@kili.mountain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Mar 03, 2020 at 01:13:06PM +0300, Dan Carpenter wrote:
> These functions are supposed to return negative error codes but instead
> it returns true on failure and false on success.  The error codes are
> eventually propogated back to user space.
> 
> Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index 6ed9f22e6401..fe245439adee 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -432,7 +432,7 @@ static int raydium_i2c_write_object(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static bool raydium_i2c_boot_trigger(struct i2c_client *client)
> +static int raydium_i2c_boot_trigger(struct i2c_client *client)
>  {
>  	static const u8 cmd[7][6] = {
>  		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0xD7 },
> @@ -457,10 +457,10 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
>  		}
>  	}
>  
> -	return false;
> +	return 0;
>  }
>  
> -static bool raydium_i2c_fw_trigger(struct i2c_client *client)
> +static int raydium_i2c_fw_trigger(struct i2c_client *client)
>  {
>  	static const u8 cmd[5][11] = {
>  		{ 0, 0x09, 0x71, 0x0C, 0x09, 0x00, 0x50, 0xD7, 0, 0, 0 },
> @@ -483,7 +483,7 @@ static bool raydium_i2c_fw_trigger(struct i2c_client *client)
>  		}
>  	}
>  
> -	return false;
> +	return 0;
>  }
>  
>  static int raydium_i2c_check_path(struct i2c_client *client)
> -- 
> 2.11.0
> 

-- 
Dmitry
