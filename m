From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 1/2] input: rotary-encoder: refactor and clean up
Date: Wed, 6 Apr 2011 18:30:56 -0500
Message-ID: <0D753D10438DA54287A00B027084269764D1D78457@AUSP01VMBX24.collaborationhost.net>
References: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
 <1302027313-27130-2-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail160.messagelabs.com ([216.82.253.99]:44984 "EHLO
	mail160.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013Ab1DFXa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 19:30:58 -0400
In-Reply-To: <1302027313-27130-2-git-send-email-jhovold@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tuesday, April 05, 2011 11:15 AM, Johan Hovold wrote:
>
> Refactor state retrieval and event reporting in interrupt handler.
> Remove a few empty lines.
>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  drivers/input/misc/rotary_encoder.c |   83 ++++++++++++++++++++--------------
>  1 files changed, 49 insertions(+), 34 deletions(-)

Looks sane to me.

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
