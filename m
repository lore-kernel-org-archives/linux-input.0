From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [Patch 08/10] input: Touchscreen driver for the PCAP
Date: Tue, 08 Jul 2008 15:40:43 +0800
Message-ID: <487319FB.5040907@gmail.com>
References: <20080707184000.411913919@datenfreihafen.org> <20080707184131.286622542@datenfreihafen.org> <20080707161212.ZZRA012@mailhub.coreip.homeip.net> <20080707202200.GB3449@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:32564 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYGHHku (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jul 2008 03:40:50 -0400
Received: by ti-out-0910.google.com with SMTP id b6so719939tic.23
        for <linux-input@vger.kernel.org>; Tue, 08 Jul 2008 00:40:48 -0700 (PDT)
In-Reply-To: <20080707202200.GB3449@datenfreihafen.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, Daniel Ribeiro <wyrm@openezx.org>

Stefan Schmidt wrote:
> Hello.
> 
> On Mon, 2008-07-07 at 16:13, Dmitry Torokhov wrote:
>> On Mon, Jul 07, 2008 at 08:40:08PM +0200, stefan@datenfreihafen.org wrote:
>>> +
>>> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>>> +	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>>> +	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
>>> +	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
>>> +	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
>>> +			     PRESSURE_MAX, 0, 0);
>>> +
>>> +	input_register_device(pcap_ts->input);
>> Please add error handling here, otherwise looks good.
> 
> Ok.New patch somes tomorrow. Need sleep now.
> 

Well, one small nit: I'm not a language lawyer, but I don't think usage of
u_int32_t/u_int16_t/u_int8_t is encourage nowadays, use uin32_t/uint16_t/uint8_t
or u32/u16/u8.

Note: I'm not going to start an argument on which is the correct one to
use, so it's totally up to you.

