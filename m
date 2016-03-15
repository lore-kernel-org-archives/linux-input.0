From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] Input: synaptics-rmi4 - using logical instead of bitwise
 AND
Date: Tue, 15 Mar 2016 11:37:54 +0300
Message-ID: <20160315083754.GA30221@mwanda>
References: <20160315071140.GF13560@mwanda>
 <1458030809.11972.178.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458030809.11972.178.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Henrik Rydberg <rydberg@bitmath.org>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 15, 2016 at 01:33:29AM -0700, Joe Perches wrote:
> Right and as well these are bool so the !! isn't necessary.

Not necessary but nice for reading...

regards,
dan carpenter
