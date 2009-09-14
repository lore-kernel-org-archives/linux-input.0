From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] input/keyboard: new OpenCores Keyboard Controller
 driver
Date: Mon, 14 Sep 2009 00:25:29 -0700
Message-ID: <1252913129.4400.247.camel@Joe-Laptop.home>
References: <1252894678-26929-1-git-send-email-vapier@gentoo.org>
	 <1252911864-19233-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:1150 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbZINHZ0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 03:25:26 -0400
In-Reply-To: <1252911864-19233-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>, Bryan Wu <cooloney@kernel.org>

On Mon, 2009-09-14 at 03:04 -0400, Mike Frysinger wrote:
> From: Javier Herrero <jherrero@hvsistemas.es>
> +#define pr_fmt(fmt) DRV_NAME ": " fmt

perhaps:
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt


