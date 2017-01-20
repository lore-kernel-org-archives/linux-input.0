From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 1/7] Input: pwm-beeper - remove calls to legacy
 pwm_request API
Date: Fri, 20 Jan 2017 13:37:13 -0600
Message-ID: <3724fd8c-c2ed-05de-87d4-149440dba2e6@lechnology.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:55913 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbdATThI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 14:37:08 -0500
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>

On 01/19/2017 04:40 PM, Dmitry Torokhov wrote:
> There are no more users of pwm-beeper driver in mainline relying on
> this legacy API, so let's remove it and simplify the driver code.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---


I've tested this patch series on LEGO MINDSTORMS EV3 and it looks good 
to me. I am not able to test the suspend race condition, but other than 
that (for the whole series)...

Tested-By: David Lechner <david@lechnology.com>

