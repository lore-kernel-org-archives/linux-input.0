From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] INPUT: fix hidinput_connect ignoring retval from input_register_device
Date: Mon, 29 Oct 2007 13:11:40 -0400
Message-ID: <d120d5000710291011u19baaf2avaef6d4b9e5ce003b@mail.gmail.com>
References: <4725F2DF.1060500@garzik.org>
	 <20071029152050.GA23411@bigserver.hohndel.org>
	 <d120d5000710290833i5ed524d6ne95fc1ef34834566@mail.gmail.com>
	 <3CE5A712-C0BE-45EE-9171-C3B54F789483@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CE5A712-C0BE-45EE-9171-C3B54F789483@linux.intel.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Hohndel, Dirk" <hohndel@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/29/07, Hohndel, Dirk <hohndel@linux.intel.com> wrote:
>
> On Oct 29, 2007, at 8:33 AM, Dmitry Torokhov wrote:
>
> > On 10/29/07, Dirk Hohndel <hohndel@linux.intel.com> wrote:
> >>
> >> Actually, the more I look at the code that bails when it runs out
> >> of memory,
> >> the more I wonder about that.
> >>
> >>        hidinput = kzalloc(sizeof(*hidinput), GFP_KERNEL);
> >>        input_dev = input_allocate_device();
> >>        if (!hidinput || !input_dev) {
> >>                kfree(hidinput);
> >>                input_free_device(input_dev);
> >>
> >> This either passes a NULL pointer to kfree or to
> >> input_free_device. That's
> >> not nice.
> >>
> >
> > No, that's allright. input_free_device() takes after kfree() so that
> > it safe to call it with NULL pointer.
>
> Ahh - should have checked that.
>
> Will the rest of the patch work with the call to hidinput_disconnect?

Yes, I think it will.

-- 
Dmitry
