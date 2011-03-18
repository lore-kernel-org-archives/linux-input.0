From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: kernel input driver and loadkeys
Date: Fri, 18 Mar 2011 14:58:05 -0700
Message-ID: <201103181458.05888.dmitry.torokhov@gmail.com>
References: <AANLkTimKaMQ47+b_1xaHPzUDjwO=dJLAJo-RhKxhsLic@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39880 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590Ab1CRV6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2011 17:58:12 -0400
Received: by iwn34 with SMTP id 34so4445027iwn.19
        for <linux-input@vger.kernel.org>; Fri, 18 Mar 2011 14:58:11 -0700 (PDT)
In-Reply-To: <AANLkTimKaMQ47+b_1xaHPzUDjwO=dJLAJo-RhKxhsLic@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Christian,

On Friday, March 18, 2011 01:05:56 am Christian Gmeiner wrote:
> Hi all,
> 
> at the moment I am writing my first linux input driver. The keypad is
> organized as a matrix, where each edge
> should be configured to send a defined keycode.
> 
> What needs to be done in the driver to support loadkeys functionality?
> If I have read loadkeys examples correctly
> it must be possible to support stuff like alphanumeric input - or I am
> wrong with this point?
> 
> The current state of the driver delivers row and column of the pressed
> key - so good so far.
> 

Have you looked into existing drivers though? Especially into 
drivers/input/keyboard/matrix_keypad.c?

Thanks.

-- 
Dmitry
