From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 2/2] Input: phantom, add a new driver
Date: Fri, 20 Apr 2007 11:01:09 +0200
Message-ID: <46288155.7060701@gmail.com>
References: <210731960111436322@karneval.cz>	<258431179037841809@karneval.cz> <20070419230719.a118a132.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070419230719.a118a132.akpm@linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, johann deneux <johann.deneux@gmail.com>, Dmitry Torokhov <dtor@insightbb.com>, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Andrew Morton napsal(a):
> On Tue, 17 Apr 2007 22:02:10 +0200 (CEST) Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> phantom, add a new driver
[...]
>> +#define PHANTOM_VERSION		"n0.9.4"
> 
> That's an impressive version number ;)

fork of 0.8 or so 2.4 linux driver -> the n in the meaning of new :)

>> +#define PHM_MAX_TORQUES		3
>> +
>> +#define PHN_CONTROL		0x6
>> +#define PHN_CTL_AMP		0x1
>> +#define PHN_CTL_BUT		0x2
>> +#define PHN_CTL_IRQ		0x10
>> +
>> +#define PHN_IRQCTL		0x4c
>> +
>> +#define PHN_ZERO_FORCE		2048
> 
> <wonders what all those do>

I have no clue too, cut&paste from sensable 2.4 driver. But I'll document as
much as possible.

>> +#define PCI_ENCODER(dev, axis) ((0 - (int)ioread32((dev)->iaddr + (axis))) & \
>> +									0xffff)
> 
> Is there any reason why this cannot be a lower-cased inline C function? 
> Nicer to read, typesafe, etc.

yes, I'll switch it.

>> +#define PHB_RUNNING		1
>> +#define PHB_RESET		2
>> +
>> +static struct PH_CLASSTYPE *phantom_class;
> 
> I guess that PH_CLASSTYPE is some protect-me-from-gregkh compatibility
> thing.  But there isn't such a macro in the tree.  I switched this to plain
> old `class'.

Yes, my bad.

>> +
>> +static irqreturn_t phantom_isr(int irq, void *data)
>> +{
>> +	struct phantom_device *dev = data;
>> +	struct input_dev *idev = dev->idev;
>> +	unsigned int a, hw_status;
>> +
>> +	hw_status = ioread32(dev->iaddr + PHN_CONTROL);
>> +	if (!(hw_status & PHN_CTL_IRQ))
>> +		return IRQ_NONE;
>> +
>> +	iowrite32(0, dev->iaddr);
>> +	wmb();
>> +	iowrite32(0xc0, dev->iaddr);
> 
> there too.

Seems reasonable, it can't be reordered. (I hope this holds on all archs.)

>> +	if (unlikely(idev == NULL))
>> +		return IRQ_HANDLED;
> 
> Can this happen?  If so, a comment explaining why would be nice.

In the case of DEBUG_SHIRQ=y. Comment will be added or better -- devinit code
reordered.

thanks for notes,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
