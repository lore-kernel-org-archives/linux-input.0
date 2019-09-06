From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: hidp: Fix assumptions on the return value of
 hidp_send_message
Date: Fri, 6 Sep 2019 15:57:23 +0200
Message-ID: <3D70AB75-FEFB-4EB3-9AC8-3BCE90F5458D@holtmann.org>
References: <20190906101306.GA12017@kadam>
 <20190906110645.27601-1-streetwalkermc@gmail.com>
 <nycvar.YFH.7.76.1909061330390.31470@cbobk.fhfr.pm>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1909061330390.31470@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Elkouby <streetwalkermc@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Brian Norris <computersforpeace@gmail.com>, Fabian Henneke <fabian.henneke@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

>> hidp_send_message was changed to return non-zero values on success,
>> which some other bits did not expect. This caused spurious errors to be
>> propagated through the stack, breaking some drivers, such as hid-sony
>> for the Dualshock 4 in Bluetooth mode.
>> 
>> As pointed out by Dan Carpenter, hid-microsoft directly relied on that
>> assumption as well.
>> 
>> Fixes: 48d9cc9d85dd ("Bluetooth: hidp: Let hidp_send_message return number of queued bytes")
>> 
>> Signed-off-by: Dan Elkouby <streetwalkermc@gmail.com>
> 
> Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> 
> Marcel, are you taking this through your tree?

I am taking this through my tree. And yes, I applied the updated patch, but answered the other ;)

Regards

Marcel
