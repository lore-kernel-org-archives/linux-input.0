From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: adding __init/__exit macros to twinhan.c
Date: Tue, 29 Sep 2009 13:58:38 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0909291358280.9280@wotan.suse.de>
References: <200909290324.56042.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-1050125348-1254225520=:9280"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753872AbZI2L6k@vger.kernel.org>
In-Reply-To: <200909290324.56042.PeterHuewe@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Bruno Premont <bonbons@linux-vserver.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-1050125348-1254225520=:9280
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 29 Sep 2009, Peter Hüwe wrote:

> From: Peter Huewe <peterhuewe@gmx.de>
> 
> Trivial patch which adds the __init/__exit macros to the module_init/
> module_exit functions of the twinhan driver in hid.
> 
> Jiri, I guess this time you can decide wether it's the hid or the trivial 
> tree ;) - thanks jiri for all your patience and work!
> 
> linux version v2.6.32-rc1 - linus git tree, Di 29. Sep 01:10:18 CEST 2009
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> diff --git a/drivers/hid/hid-twinhan.c b/drivers/hid/hid-twinhan.c
> index b05f602..c40afc5 100644
> --- a/drivers/hid/hid-twinhan.c
> +++ b/drivers/hid/hid-twinhan.c
> @@ -132,12 +132,12 @@ static struct hid_driver twinhan_driver = {
>  	.input_mapping = twinhan_input_mapping,
>  };
>  
> -static int twinhan_init(void)
> +static int __init twinhan_init(void)
>  {
>  	return hid_register_driver(&twinhan_driver);
>  }
>  
> -static void twinhan_exit(void)
> +static void __exit twinhan_exit(void)
>  {
>  	hid_unregister_driver(&twinhan_driver);
>  }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--168427776-1050125348-1254225520=:9280--
