From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: New forcefeedback device support
Date: Wed, 6 Jun 2007 09:21:08 +0200
Message-ID: <38b3b7c0706060021g3c64c305h75fd68e75a01352d@mail.gmail.com>
References: <1180990414.10616.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180990414.10616.7.camel@localhost>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

You need to add the usb vendor and device ids to the iforce driver. If
you don't know how to do that, just send me these ids, I'll send you a
modified driver which you can try.

On 6/4/07, Dmitriy Geels <dmitriy.geels@gmail.com> wrote:
> Hello all!
>
> I'm interested in adding force feedback support for my gamepad - Saitek
> Rumblepad P2600. I think, this is i-force device, but loading iforce
> module doesn't help.
>
> --
> GPG Public Key ID: E3847861
>
>
