From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH] Input: tca8418-keypad - switch to use managed resources
Date: Wed, 14 Nov 2012 11:47:37 +0100
Message-ID: <20121114114737.16e33404@avionic-0020.adnet.avionic-design.de>
References: <20121108170932.GA28478@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59834 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932836Ab2KNKro (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 05:47:44 -0500
In-Reply-To: <20121108170932.GA28478@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alban Bedel <alban.bedel@avionic-design.de>

On Thu, 8 Nov 2012 09:09:34 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Let's switch to using devm_*() interfaces to manage our resources, thus will
> simplify error unwinding a bit.
> 

LGTM but I would suggest splitting it with the "niceness" changes
(client->dev to dev, etc) in one patch and the devm conversion in
another.

Alban
