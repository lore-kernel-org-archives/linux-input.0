From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sentelic - use "static inline" instead of "inline"
Date: Fri, 22 May 2015 09:57:05 -0700
Message-ID: <20150522165705.GB40101@dtor-ws>
References: <1430072122-9902-1-git-send-email-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35995 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbbEVQ5J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 12:57:09 -0400
Received: by iepj10 with SMTP id j10so35507617iep.3
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 09:57:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430072122-9902-1-git-send-email-raj.khem@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, Apr 26, 2015 at 06:15:22PM +0000, Khem Raj wrote:
> gcc-5 defaults to gnu11 which used c99 inline semantics
> in c99 'inline' is not externally visible unlike gnu89, therefore
> we use 'static inline' which has same semantics between gnu89 and c99
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/sentelic.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
> index aa697ec..42df9e3 100644
> --- a/drivers/input/mouse/sentelic.h
> +++ b/drivers/input/mouse/sentelic.h
> @@ -123,11 +123,11 @@ struct fsp_data {
>  extern int fsp_detect(struct psmouse *psmouse, bool set_properties);
>  extern int fsp_init(struct psmouse *psmouse);
>  #else
> -inline int fsp_detect(struct psmouse *psmouse, bool set_properties)
> +static inline int fsp_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	return -ENOSYS;
>  }
> -inline int fsp_init(struct psmouse *psmouse)
> +static inline int fsp_init(struct psmouse *psmouse)
>  {
>  	return -ENOSYS;
>  }
> -- 
> 2.1.4
> 

-- 
Dmitry
