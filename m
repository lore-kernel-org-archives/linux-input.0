From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: driver updates based on review
Date: Fri, 11 Jul 2008 08:35:41 +0200
Message-ID: <871w21lygy.fsf@macbook.be.48ers.dk>
References: <20080710193451.ED2B51D18066@mail97-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:36608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbYGKGfv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2008 02:35:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so36525ugf.16
        for <linux-input@vger.kernel.org>; Thu, 10 Jul 2008 23:35:45 -0700 (PDT)
In-Reply-To: <20080710193451.ED2B51D18066@mail97-dub.bigfish.com> (John Linn's message of "Thu\, 10 Jul 2008 12\:34\:43 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com, Sadanand <sadanan@xilinx.com>

>>>>> "John" == John Linn <john.linn@xilinx.com> writes:

 John> Review comments were incorporated to improve the driver.
 John> 1. Some data was eliminated that was not needed.
 John> 2. Renaming of variables for clarity.
 John> 3. Removed unneeded type casting.
 John> 4. Changed to use dev_err rather than other I/O.
 John> 5. Merged together some functions.
 John> 6. Added kerneldoc format to functions.

 John> Signed-off-by: Sadanand <sadanan@xilinx.com>
 John> Signed-off-by: John Linn <john.linn@xilinx.com>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
