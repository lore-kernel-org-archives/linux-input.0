From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RESEND PATCH v3 1/6] mfd: cros_ec: Add MKBP event support
Date: Wed, 2 Mar 2016 12:34:12 +0000
Message-ID: <20160302123412.48725889@lxorguk.ukuu.org.uk>
References: <1456907012-19268-1-git-send-email-tomeu.vizoso@collabora.com>
	<1456907012-19268-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37942 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbcCBMeh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 07:34:37 -0500
In-Reply-To: <1456907012-19268-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Enric =?UTF-8?B?QmFsbGV0YsOy?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


> +static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
> +	u16 cmd, u32 *mask)
> +{
> +	struct ec_params_get_cmd_versions *pver;
> +	struct ec_response_get_cmd_versions *rver;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
> +		      GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = 0;
> +	msg->command = EC_CMD_GET_CMD_VERSIONS;
> +	msg->insize = sizeof(rver);
> +	msg->outsize = sizeof(pver);

*rver and *pver surely ?


