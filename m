From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] OLPC: touchpad driver (take 2)
Date: Thu, 11 Sep 2008 08:59:57 -0400
Message-ID: <20080911085753.ZZRA012@mailhub.coreip.homeip.net>
References: <20080813152459.4d6bb0cb@ephemeral> <20080815031435.GD9438@anvil.corenet.prv> <20080910175513.17d900bc@dev.queued.net> <20080911010124.79166d64@dev.queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.246]:14980 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbYIKNAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2008 09:00:04 -0400
Received: by hs-out-0708.google.com with SMTP id 4so118578hsl.5
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2008 06:00:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080911010124.79166d64@dev.queued.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andres,

On Thu, Sep 11, 2008 at 01:01:24AM -0400, Andres Salomon wrote:
> @@ -114,7 +115,7 @@ ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *at
>  ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *attr,
>  				const char *buf, size_t count);
>  
> -#define PSMOUSE_DEFINE_ATTR(_name, _mode, _data, _show, _set)			\
> +#define PSMOUSE_DEFINE_ATTR(_name, _mode, _data, _protected_set, _show, _set)	\
>  static ssize_t _show(struct psmouse *, void *data, char *);			\
>  static ssize_t _set(struct psmouse *, void *data, const char *, size_t);	\
>  static struct psmouse_attribute psmouse_attr_##_name = {			\
> @@ -129,6 +130,7 @@ static struct psmouse_attribute psmouse_attr_##_name = {			\
>  	.data	= _data,							\
>  	.show	= _show,							\
>  	.set	= _set,								\
> +	.protected_set = _protected_set,					\
>  }
>  

I would rather you defined __PSMOUSE_DEFINE_ATTR() with 'protected'
argument and then defined PSMOUSE_DEFINE_ATTR() through underscored
version so that nothing else need to be changed.

-- 
Dmitry
