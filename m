From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: rfkill-input understanding help
Date: Fri, 11 Jan 2008 15:34:09 -0500
Message-ID: <d120d5000801111234k5c0faaeeya0c5487ede8f0c19@mail.gmail.com>
References: <200712110333.40946.carlos@strangeworlds.co.uk>
	 <200801022010.21109.IvDoorn@gmail.com>
	 <200801110323.38279.carlos@strangeworlds.co.uk>
	 <200801112008.00927.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:57362 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759264AbYAKUeO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 15:34:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so972620fkz.5
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 12:34:11 -0800 (PST)
In-Reply-To: <200801112008.00927.IvDoorn@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-input@vger.kernel.org

On Jan 11, 2008 2:08 PM, Ivo van Doorn <ivdoorn@gmail.com> wrote:
>
> Perhaps the rfkill-input needs to be registered before input
> devices are being registered. But I am not sure, Dmitry propably
> knows more about possible ordering requirements for input
> device and input trigger registration.
>

No, it is ok for rfkill-input handler to be installed later, but of
course it will miss any events that happen before.

-- 
Dmitry
