From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Thu, 24 Sep 2009 10:43:48 -0300
Message-ID: <200909241043.48392.lamarque@gmail.com>
References: <200908062247.29254.lamarque@gmail.com> <200909221319.45013.lamarque@gmail.com> <alpine.LSU.2.00.0909241137300.9280@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:40638 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbZIXNn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 09:43:56 -0400
Received: by qw-out-2122.google.com with SMTP id 5so602253qwd.37
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2009 06:43:59 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.0909241137300.9280@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

Em Quinta-feira 24 Setembro 2009, Jiri Kosina escreveu:
> Is this wonky behavior of this mouse regression from older kernels, or has
> the mouse been misbehaving in HID mode all the time?

	It is misbehaving since hid session was made default in kernel 2.6.22. Until 
kernel 2.6.21 input session was the default.

-- 
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/
