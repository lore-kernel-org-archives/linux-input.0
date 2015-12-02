From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Wed, 2 Dec 2015 06:03:07 -0500 (EST)
Message-ID: <1052675973.31763834.1449054187055.JavaMail.zimbra@redhat.com>
References: <1448467088-7703-1-git-send-email-vdronov@redhat.com> <20151201211614.GB3740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:38043 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbbLBLDI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 06:03:08 -0500
In-Reply-To: <20151201211614.GB3740@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello, Dmitry,

> > +	if (intf->altsetting[0].desc.bNumEndpoints < 1) {
> > +		dev_warn(&intf->dev,
>
> This should be dev_err as we are aborting device initialization. I know
> the driver user warn/info in similar places, but it is not right, we
> might want to adjust it at some point.

Yes, the driver using dev_warn() in all the similar error paths was a
reason for me to use dev_warn() here.

> > +		err = -ENODEV;
>
> I believe it should be -EINVAL as well. I adjusted the above 3 items
> and applied.

Indeed, this suits best. Thank you for handling this and the issue in
general.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
