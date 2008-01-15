From: Timo Aaltonen <tjaalton@cc.hut.fi>
Subject: support for Logitech Wave
Date: Tue, 15 Jan 2008 15:49:14 +0200 (EET)
Message-ID: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-2.hut.fi ([130.233.228.92]:47730 "EHLO smtp-2.hut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbYAOOXE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2008 09:23:04 -0500
Received: from localhost (putosiko.hut.fi [130.233.228.114])
	by smtp-2.hut.fi (8.13.6/8.12.10) with ESMTP id m0FDnPZC013407
	for <linux-input@vger.kernel.org>; Tue, 15 Jan 2008 15:49:25 +0200
Received: from smtp-2.hut.fi ([130.233.228.92])
 by localhost (putosiko.hut.fi [130.233.228.114]) (amavisd-new, port 10024)
 with LMTP id 21871-49 for <linux-input@vger.kernel.org>;
 Tue, 15 Jan 2008 15:49:25 +0200 (EET)
Received: from replicant.hut.fi (replicant.hut.fi [130.233.200.84])
	by smtp-2.hut.fi (8.13.6/8.12.10) with ESMTP id m0FDnELC013363
	for <linux-input@vger.kernel.org>; Tue, 15 Jan 2008 15:49:14 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


 	Hi

   I've got a Logitech Wave keyboard, that has a number of extra keys on 
it, and most of them fail to work with evdev. I get no output with xev or 
while trying to cat the input device. I've been told that it's a kernel 
issue if the device shows no events, hence this email.

What should I do to get full support for all the keys on it? It's a nice 
keyboard, so I'd like to get the most of it :)

t
