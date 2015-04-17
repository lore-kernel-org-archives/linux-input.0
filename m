From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: Unusual Focaltech driver behavior
Date: Fri, 17 Apr 2015 12:56:46 +0300
Message-ID: <5530D8DE.7070604@gmail.com>
References: <5530C7D2.8090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34295 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbbDQJ4t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2015 05:56:49 -0400
Received: by lbcga7 with SMTP id ga7so78770165lbc.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2015 02:56:48 -0700 (PDT)
In-Reply-To: <5530C7D2.8090106@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mgottschlag@gmail.com

> I noticed that myself and got some complaints like this.
> https://github.com/hanipouspilot/ubuntu-fixes/issues/2
> 
> General issue is that when one finger is on the touchpad, movement of a second finger is ignored, if the first finger does not move.
> Usually with other touchpads, when you have one finger on the touchpad and move the other, it is recognized as two-finger scrolling.
> The device itself sends relative packages as normal in that case, but linux driver ignores them, until first finger is moved.
> 
> I guess, Windows driver behaves same way. I can't test it, since I do not have Windows installed on that laptop.
> 
> As I understood, Windows driver ignores that one finger is on button area and recognizes movement of the other as one-finger movement.
> 
> It is clear that we do not know the full protocol or parameters of all touchpad models to have that button area always correct.
> But it looks like button area is set when 3rd byte in abs package is 00. There is a good chance that it is common for all touchpad models.
> 
> Do you have ideas how to fix it the easiest way?
> 
> Regards,
> 
> Dmitry
> 

I looked at it some more and noticed that if I put one finger on touchpad, then another, then move the second one, rel packets are ignored.
But if keeping both fingers on touchpad, I move the first one, rel packets work OK.
This is wrong. I can't get what's wrong with the code at the moment.
