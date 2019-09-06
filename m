From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Bluetooth: hidp: Fix assumptions on the return value of
 hidp_send_message
Date: Fri, 6 Sep 2019 13:31:06 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909061330390.31470@cbobk.fhfr.pm>
References: <20190906101306.GA12017@kadam> <20190906110645.27601-1-streetwalkermc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190906110645.27601-1-streetwalkermc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Elkouby <streetwalkermc@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Brian Norris <computersforpeace@gmail.com>, Fabian Henneke <fabian.henneke@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 6 Sep 2019, Dan Elkouby wrote:

> hidp_send_message was changed to return non-zero values on success,
> which some other bits did not expect. This caused spurious errors to be
> propagated through the stack, breaking some drivers, such as hid-sony
> for the Dualshock 4 in Bluetooth mode.
> 
> As pointed out by Dan Carpenter, hid-microsoft directly relied on that
> assumption as well.
> 
> Fixes: 48d9cc9d85dd ("Bluetooth: hidp: Let hidp_send_message return number of queued bytes")
> 
> Signed-off-by: Dan Elkouby <streetwalkermc@gmail.com>

Reviewed-by: Jiri Kosina <jkosina@suse.cz>

Marcel, are you taking this through your tree?

Thanks,

-- 
Jiri Kosina
SUSE Labs
