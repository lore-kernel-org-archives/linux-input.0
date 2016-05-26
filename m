From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH v4] input: tablet: add Pegasus Notetaker tablet driver
Date: Thu, 26 May 2016 16:37:36 +0200
Message-ID: <57470A30.4060104@posteo.de>
References: <1464162274-18424-1-git-send-email-martink@posteo.de>
 <20160526002923.GD22369@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160526002923.GD22369@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, kernel-testers@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 2016-05-26 um 02:29 schrieb Dmitry Torokhov:
> Hi Martin,
> 
> On Wed, May 25, 2016 at 09:44:34AM +0200, Martin Kepplinger wrote:
>> This adds a driver for the Pegasus Notetaker Pen. When connected,
>> this uses the Pen as an input tablet.
>>
>> This device was sold in various different brandings, for example
>> 	"Pegasus Mobile Notetaker M210",
>> 	"Genie e-note The Notetaker",
>> 	"Staedtler Digital ballpoint pen 990 01",
>> 	"IRISnotes Express" or
>> 	"NEWLink Digital Note Taker".
>>
>> Here's an example, so that you know what we are talking about:
>> http://www.staedtler.com/en/products/ink-writing-instruments/ballpoint-pens/digital-pen-990-01-digital-ballpoint-pen
>>
>> http://pegatech.blogspot.com/ seems to be a remaining official resource.
>>
>> This device can also transfer saved (offline recorded handwritten) data and
>> there are userspace programs that do this, see https://launchpad.net/m210
>> (Well, alternatively there are really fast scanners out there :)
>>
>> It's *really* fun to use as an input tablet though! So let's support this
>> for everybody.
>>
>> There's no way to disable the device. When the pen is out of range, we just
>> don't get any URBs and don't do anything.
>> Like all other mouses or input tablets, we don't use runtime PM.
>>
>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> ---
>>
>> Thanks for having a look. Any more suggestions on this?
>>
>> revision history
>> ================
>> v4 use normal work queue instead of a kernel thread (thanks to Oliver Neukum)
>> v3 fix reporting low pen battery and add USB list to CC
>> v2 minor cleanup (remove unnecessary variables)
>> v1 initial release
>>

Hi Dmitry,

thanks for the excellent review! All your suggestions seem valuable so
far and I'll prepare a new version for you.

>> +
>> +static int pegasus_open(struct input_dev *dev)
>> +{
>> +	struct pegasus *pegasus = input_get_drvdata(dev);
>> +
>> +	pegasus->irq->dev = pegasus->usbdev;
> 
> Is this assignment really needed?
> 

If we set URB_NO_TRANSFER_DMA_MAP and use transfer_dma, yes.


thanks again,

                              martin
