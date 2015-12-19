From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] Input: egalax: potential NULL dereference on error
Date: Sat, 19 Dec 2015 23:04:14 +0300
Message-ID: <20151219200414.GO5284@mwanda>
References: <20151219105824.GA3749@mwanda>
 <alpine.DEB.2.02.1512191204430.2055@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1512191204430.2055@localhost6.localdomain6>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Dec 19, 2015 at 12:04:56PM +0100, Julia Lawall wrote:
> On Sat, 19 Dec 2015, Dan Carpenter wrote:
> 
> > We didn't check input_allocate_device() for failures so it could lead to
> > a NULL deref.
> 
> The patch does several other things...

Not really.  It's all part of fixing the input_allocate_device() check.

regards,
dan carpenter

