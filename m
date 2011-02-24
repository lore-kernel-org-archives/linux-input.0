From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: which driver to choose for a GPIO connected switch
Date: Thu, 24 Feb 2011 09:58:38 +0100
Message-ID: <201102240958.38401.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:51941 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab1BXI6k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Feb 2011 03:58:40 -0500
Received: from comm.systec-electronic.de (178-25-116-119-dynip.superkabel.de [178.25.116.119])
	by webbox687.server-home.net (Postfix) with ESMTP id 9DA6D778068
	for <linux-input@vger.kernel.org>; Thu, 24 Feb 2011 09:58:38 +0100 (CET)
Received: from ws-stein.localnet (ws-stein.systec-electronic.de [192.168.10.93])
	by comm.systec-electronic.de (Postfix) with ESMTP id D6A5697C068
	for <linux-input@vger.kernel.org>; Thu, 24 Feb 2011 09:58:38 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm just wondering which existing input driver I can choose to use an GPIO 
connected switch. The switch I'm talking about is connected via 3 
(interruptable) GPIOs and those GPIOs can be inverted.
I think gpio-keys is wrong as they will generate events on each state change.
Note: The switch is likely to bounce and the current GPIO state might be 
invalid (all 3 GPIOs are 0).
I also think gpio-keys can't make sure only one switch state is currently 
present. So I may get a current state 1 on 2 or more GPIOs which is obviously 
wrong.
My use case is the userspace polls the current switch state if it needs to 
know.
Do you have any suggestions which driver to use or even write?

Best regards,
Alexander
