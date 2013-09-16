From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
 synthetic keyboard
Date: Mon, 16 Sep 2013 18:05:48 +0300
Message-ID: <20130916150548.GO25896@mwanda>
References: <1379309334-25042-1-git-send-email-kys@microsoft.com>
 <20130916082110.GN25896@mwanda>
 <3b5096d0190b4440a8e25afbd22ab72d@SN2PR03MB061.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <3b5096d0190b4440a8e25afbd22ab72d@SN2PR03MB061.namprd03.prod.outlook.com>
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 16, 2013 at 02:46:24PM +0000, KY Srinivasan wrote:
> > > +			case VM_PKT_DATA_INBAND:
> > > +				hv_kbd_on_receive(device, desc);
> > 
> > This is the error handling I mentioned at the top.  hv_kbd_on_receive()
> > doesn't take into consideration the amount of data we recieved, it
> > trusts the offset we recieved from the user.  There is an out of bounds
> > read.
> 
> What user are you referring to. The message is sent by the host - the user keystroke
> is normalized into a fixed size packet by the host and sent to the  guest. We will parse this
> packet, based on the host specified layout here.
> 

The user means the hypervisor, yes.

I don't want the hypervisor accessing outside of the buffer.  It is
robustness issue.  Just check the offset against "bytes_recvd".  It's
not complicated.

If you have a different place where the guest does this then tell me
which function to look at.

regards,
dan carpenter
