From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 04/20] Input: ep93xx_keypad - Remove redundant
 platform_set_drvdata()
Date: Mon, 6 May 2013 11:45:06 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021D46AC78F1@AUSP01VMBX24.collaborationhost.net>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
 <1367814240-8959-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.16]:46008 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3EFQxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 May 2013 12:53:11 -0400
In-Reply-To: <1367814240-8959-4-git-send-email-sachin.kamat@linaro.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Sunday, May 05, 2013 9:24 PM, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> ---
>  drivers/input/keyboard/ep93xx_keypad.c |    3 ---
>  1 file changed, 3 deletions(-)

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

