From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Fix check for disabling unsupported key
Date: Sun, 10 Jan 2016 19:39:22 +0200
Message-ID: <5692974A.6070601@gmail.com>
References: <1451856076-29045-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160105011942.GD11801@dtor-ws> <568B6FB8.6000101@gmail.com>
 <20160106223845.GA26606@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37616 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795AbcAJRj0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2016 12:39:26 -0500
In-Reply-To: <20160106223845.GA26606@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: pali.rohar@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On  7.01.2016 00:38, Dmitry Torokhov wrote:
>
> How about the patch below (compiled but not tested)?
>
> Thanks.
>

Tested on Nokia N900, looks good, you may add:

Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Thanks,
Ivo
