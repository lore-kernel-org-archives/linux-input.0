From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] Input: samsung-keypad - Set up driver data prior to
 registering
Date: Wed, 28 Dec 2011 11:05:08 +0000
Message-ID: <20111228110507.GA24405@opensource.wolfsonmicro.com>
References: <1325006308-21149-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111228043353.GA19976@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48640 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753631Ab1L1LFM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Dec 2011 06:05:12 -0500
Content-Disposition: inline
In-Reply-To: <20111228043353.GA19976@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-input@vger.kernel.org

On Tue, Dec 27, 2011 at 08:33:54PM -0800, Dmitry Torokhov wrote:

> I do not think this is needed. We retrieve platform data only in
> samsung_keypad_remove() and in suspend/resume methods which AFAIK will
> not be called until after probe() returns.

Hrm, yes.  In that case it should just be squashed into the second patch
as the runtime PM change will cause us to do PM as soon as the device is
opened.
