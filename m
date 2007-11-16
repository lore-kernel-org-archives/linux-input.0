From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - Move KEY_{EURO, DOLLAR} to lower keycodes
Date: Fri, 16 Nov 2007 08:47:23 -0500
Message-ID: <d120d5000711160547p5239375cs9a97956ca9b934e5@mail.gmail.com>
References: <200711161341.58696.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:54608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407AbXKPNrZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 08:47:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so644181ugc
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2007 05:47:23 -0800 (PST)
In-Reply-To: <200711161341.58696.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org

Hi Carlos,

On Nov 16, 2007 8:41 AM, Carlos Corbacho <carlos@strangeworlds.co.uk> wrote:
> From: Carlos Corbacho <cathectic@gmail.com>
>
> These keys are used on PS/2 controllers, so their current values are too
> high to map the scancodes to. Move them to the < 256 range.
>

They should stay where they were. We need to change atkbd to use
ushorts in keymaps. I have a patch for it, I'll forward it to you
today or tomorrow.

-- 
Dmitry
