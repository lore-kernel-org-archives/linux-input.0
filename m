From: Daniel Mack <daniel@caiaq.de>
Subject: Query last reported event state
Date: Tue, 24 Nov 2009 18:33:56 +0100
Message-ID: <20091124173356.GB14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:38840 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933582AbZKXRdx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2009 12:33:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 175767F407B
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2009 18:33:59 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XDsdA+gEYlB for <linux-input@vger.kernel.org>;
	Tue, 24 Nov 2009 18:33:56 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

is there a way to query the last state an input device reported,
preferably even for a special key mask? When a button is pressed and a
userspace application is started, it should be able to figure out the
current state, especially because those GPIO signals are likely
connected to other peripherals to report arbitrary events in the system.
Is there any such framework for that purpose?

A somewhat related topic is: Looking at the gpio_keys.c for example, I
think there should be code that reports an event from probe() when the
configured GPIO is not in its 'inactive' state, otherwise it will loose
the first key-up event, right?

Thanks,
Daniel

