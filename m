From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] Input: goodix: Add support for capacitive home button
Date: Wed, 06 Sep 2017 11:00:19 +0200
Message-ID: <1504688419.6911.55.camel@hadess.net>
References: <20170620160835.13904-1-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58807 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdIFJAX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 6 Sep 2017 05:00:23 -0400
In-Reply-To: <20170620160835.13904-1-hadess@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, "Sergei A. Trusov" <sergei.a.trusov@ya.ru>

Hey,

On Tue, 2017-06-20 at 18:08 +0200, Bastien Nocera wrote:
> From: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>
> 
> On some x86 tablets with a Goodix touchscreen, the Windows logo on
> the
> front is a capacitive home button. Touching this button results in a
> touch
> with bit 4 of the first byte set, while only the lower 4 bits (0-3)
> are
> used to indicate the number of touches.
> 
> Report a KEY_LEFTMETA press when this happens.
> 
> Note that the hardware might support more than one button, in which
> case the "id" byte of coor_data would identify the button in
> question.
> This is not implemented as we don't have access to hardware with
> multiple buttons.
> 
> Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>
> Acked-by: Bastien Nocera <hadess@hadess.net>

Can we please get this merged? I didn't receive any reviews on it, and
it's been sitting there for 2 months...
