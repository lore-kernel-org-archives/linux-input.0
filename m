From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
 synthetic keyboard
Date: Mon, 16 Sep 2013 23:13:28 +0300
Message-ID: <20130916201328.GN19256@mwanda>
References: <1379309334-25042-1-git-send-email-kys@microsoft.com>
 <20130916082110.GN25896@mwanda>
 <3b5096d0190b4440a8e25afbd22ab72d@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916150548.GO25896@mwanda>
 <baabf219b12b40de8e17b029e621e079@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916170951.GB20734@core.coreip.homeip.net>
 <3e45f054c6e243eabf2896ab1dcf38d4@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916183319.GM19256@mwanda>
 <117fbf407a554684b4d72ab06b033eeb@SN2PR03MB061.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <117fbf407a554684b4d72ab06b033eeb@SN2PR03MB061.namprd03.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 16, 2013 at 06:42:25PM +0000, KY Srinivasan wrote:
> Dan,
> 
> Rolling the changes you have indicated is not the issue; this can trivially be done.
> My contention is that it is not needed given that the underlying function is already
> doing that. Look at the function  vmbus_recvpacket_raw() in drivers/hv/channel.c.
> 

I'm confused.

There is no mention of ->offset8 in vmbus_recvpacket_raw().

It's a good idea to add a check there but the lower levels don't know
about the sizeof(synth_kbd_protocol_response) so we would still need
something like my check.

regards,
dan carpenter
