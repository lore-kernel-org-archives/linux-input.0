From: josep.sanchez.ferreres@est.fib.upc.edu
Subject: RE: Bug report - Input device stopped working ater 3.17 (and isn't
	working with the latest kernel)
Date: Mon, 08 Dec 2014 21:09:42 +0100
Message-ID: <20141208210942.l7sfuqbb2g48gw0g@webmail.fib.upc.es>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2.fib.upc.es ([147.83.41.106]:40102 "EHLO mail2.fib.upc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbaLHUJv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Dec 2014 15:09:51 -0500
Received: from teron.localdomain (viruspam2.fib.upc.es [147.83.41.74])
	by mail2.fib.upc.es (Postfix) with ESMTP id 4C2CD3C434
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 21:09:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by teron.localdomain (Postfix) with ESMTP id 4416C3C436
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 21:09:49 +0100 (CET)
Received: from teron.localdomain ([147.83.41.74])
	by localhost (teron.fib.upc.es [127.0.0.1]) (amavisd-new, port 30024)
	with ESMTP id BJPePVRiNdY5 for <linux-input@vger.kernel.org>;
	Mon,  8 Dec 2014 21:09:43 +0100 (CET)
Received: from mail2.fib.upc.es (mail2.fib.upc.es [147.83.41.106])
	by teron.localdomain (Postfix) with ESMTP id 806783C434
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 21:09:43 +0100 (CET)
Received: from mail2.fib.upc.es (mail2.fib.upc.es [147.83.41.106])
	by mail2.fib.upc.es (Postfix) with ESMTP id 7A8933C436
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 21:09:43 +0100 (CET)
Received: from webmail.fib.upc.es (foc3.fib.upc.es [147.83.41.83])
	by mail2.fib.upc.es (Postfix) with ESMTP id 6D6A63C434
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 21:09:43 +0100 (CET)
Received: from foc3.fib.upc.es (localhost [127.0.0.1])
	by webmail.fib.upc.es (Postfix) with ESMTP id 8446D4E21
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 21:09:42 +0100 (CET)
Received: (from www@localhost)
	by foc3.fib.upc.es (8.13.8+Sun/8.13.8/Submit) id sB8K9giq022522
	for linux-input@vger.kernel.org; Mon, 8 Dec 2014 21:09:42 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Thank you very much.

I am collecting the requested data and I'll try to have it ASAP.

Just to make sure, I'm making two log files with hid-replay, one for  
3.16 and the other for 3.18 (should I do 3.17 as well?).

For each file I'll record all this cases (each one is a consecutive  
stream of data, I'll separate between cases).

For the touchpad (finger)

- Some circular movements (like moving the mouse cursor)
- Random taps on the screen
- Double click (to drag and drop)
- Pinch zoom gesture
- Two finger swipes in all directions
- Three finger swipes in all directions

For the pen (stylus)

- Some circular movements
- Random clicks on the screen
- Click and drag and drop
- Stylus physical button

For the keys

- Test both buttons

Should that be enough? Is it too much?

Thanks!

