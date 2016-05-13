From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] Input: pwm-beeper - defer pwm config if pwm can sleep
Date: Fri, 13 May 2016 17:38:11 +0200
Message-ID: <5735F4E3.20008@gmx.at>
References: <56C4735E.6020300@gmx.at> <20160222194639.GD26177@dtor-ws>
 <20160512121852.GB26824@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:53352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbcEMPi2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 11:38:28 -0400
In-Reply-To: <20160512121852.GB26824@ulmo.ba.sec>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 2016-05-12 14:18, Thierry Reding wrote:
> 
> I agree with Dmitry. Users of the PWM API should always assume that
> calls to the PWM API might sleep. Conditionalizing on pwm_can_sleep()
> isn't a good idea, since that function is scheduled to be removed. In
> fact it's been returning true unconditionally since v4.5, so the fast
> path is dead code anyway.
> 

In this case, the decision is clear ;-)
I'll rework and send the new patch in the next days.

best regards,
manfred

