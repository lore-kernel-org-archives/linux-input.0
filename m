From: Joe Perches <joe@perches.com>
Subject: Re: [patch] Input: synaptics-rmi4 - using logical instead of
 bitwise AND
Date: Tue, 15 Mar 2016 01:54:36 -0700
Message-ID: <1458032076.11972.179.camel@perches.com>
References: <20160315071140.GF13560@mwanda>
	 <1458030809.11972.178.camel@perches.com> <20160315083754.GA30221@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:59438 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933944AbcCOIym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 04:54:42 -0400
In-Reply-To: <20160315083754.GA30221@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Henrik Rydberg <rydberg@bitmath.org>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, 2016-03-15 at 11:37 +0300, Dan Carpenter wrote:
> On Tue, Mar 15, 2016 at 01:33:29AM -0700, Joe Perches wrote:
> > 
> > Right and as well these are bool so the !! isn't necessary.
> Not necessary but nice for reading...

<shrug> opinions vary.

cheers, Joe

