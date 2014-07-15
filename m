From: Markus Niebel <list-09_linux_input@tqsc.de>
Subject: [RFC] edt-ft5x06 - cannot see IRQ Qfrom device after DT probe
Date: Tue, 15 Jul 2014 19:43:57 +0200
Message-ID: <53C5685D.1090008@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:48846 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbaGORhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jul 2014 13:37:11 -0400
Received: from [89.246.71.91] (helo=mail6.tqsc.de)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <list-09_linux_input@tqsc.de>)
	id 1X76a9-0003WM-U9
	for linux-input@vger.kernel.org; Tue, 15 Jul 2014 19:32:01 +0200
Received: from sc1209091.tqsc.de ([192.168.168.49] helo=[127.0.0.1])
	by mail6.tqsc.de with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <list-09_linux_input@tqsc.de>)
	id 1X76a9-0001D7-HE
	for linux-input@vger.kernel.org; Tue, 15 Jul 2014 19:32:01 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hallo,

working with said tochcontroller we found that the IRQ is not seen in the following scenario:

- bootloader uses pin as an output for some reason 
- pin is configured as GPIO and as INT source via device tree
- driver loads correctly and communicates over I2C
- IRQs not seen by CPU becaus pin is still configured as output

- when adding an int-gpios node to devicetree and parsing this gpio the gpio will be configured as input
- IRQ can be seen by CPU

Question:

- shall we add an int-gpio property to enable gpio pin config as input or

Regards

Markus Niebel
