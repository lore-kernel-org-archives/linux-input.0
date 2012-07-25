From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 2/2] input: rotary-encoder: defer calls gpio_to_irq()
Date: Wed, 25 Jul 2012 11:38:34 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206AABE159A@AUSP01VMBX24.collaborationhost.net>
References: <1343151487-27841-1-git-send-email-zonque@gmail.com>
 <1343151487-27841-2-git-send-email-zonque@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F00206AABE13B5@AUSP01VMBX24.collaborationhost.net>
 <500FA387.5010504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:49558 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab2GYQii convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 12:38:38 -0400
In-Reply-To: <500FA387.5010504@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jhovold@gmail.com" <jhovold@gmail.com>

On Wednesday, July 25, 2012 12:43 AM, Daniel Mack wrote:
> On 24.07.2012 21:45, H Hartley Sweeten wrote:
>> You might want to put this patch first before adding the DT binding
>> stuff.
>> 
>> You also might consider using gpio_request_one() or even the
>> devm_* version, instead of doing the gpio_request() followed
>> by the  gpio_direction_input().
>> 
>> Actually, if you convert the probe to use the managed resource
>> devm_* stuff it would really cleanup the error path and the remove.
>
> Yes, you're right. Thanks for the hint. New version coming up. Does your
> Reviewed-by: still apply?

As pointed out by Dmitry, the devm_* stuff will not work with this driver.

Please update the patch to just use the gpio_request_one() and I'll
review it again.

Sorry about that.

Hartley
