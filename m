From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Tue, 1 Dec 2015 03:09:06 -0500 (EST)
Message-ID: <191812479.29673243.1448957346445.JavaMail.zimbra@redhat.com>
References: <Pine.LNX.4.44L0.1511301046070.1938-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:50567 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbLAIJJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 03:09:09 -0500
In-Reply-To: <Pine.LNX.4.44L0.1511301046070.1938-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello, Alan,

Thank you for the explanations and I'm sorry for my terminology
misunderstanding, I got the point now, endpoint 0 != endpoint[0].

> My advice is to fix aiptek's probe routine. It should check that 
> intf->altsetting[0].desc.bNumEndpoints > 0 before trying to accessing 
> the endpoint array.

Thank you, yes, the patch proposed does something quite alike.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
