From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] cap11xx: add LED support
Date: Tue, 09 Jun 2015 07:26:45 +0200
Message-ID: <55767915.5050206@zonque.org>
References: <1433821584-20102-1-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:47243 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616AbbFIFcN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jun 2015 01:32:13 -0400
In-Reply-To: <1433821584-20102-1-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

On 06/09/2015 05:46 AM, Matt Ranostay wrote:
> Several cap11xx variants have LEDs that be can be controlled, this
> patchset implements this functionality.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 102 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 3 deletions(-)

Ah, and please include the LED maintainers in v2, they might spot other
details :)


Thanks,
Daniel


