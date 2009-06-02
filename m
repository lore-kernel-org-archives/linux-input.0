From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Tue, 2 Jun 2009 17:14:41 +0200
Message-ID: <200906021714.42186.u.luckas@road.de>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com> <200906021655.18476.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from server.road.de ([85.10.209.111]:47346 "EHLO mail.road.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139AbZFBPOm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Jun 2009 11:14:42 -0400
In-Reply-To: <200906021655.18476.u.luckas@road.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

One more...

As all gpio handling is done in a workqueue, 
gpio_set_value_cansleep/gpio_get_value_cansleep could probably be used. This 
would make the driver ready for gpios on external controllers (via i2c for 
example).

regards,
Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien

