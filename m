From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.{28,30} Keyboard not working on oldish machine
Date: Wed, 17 Jun 2009 13:40:13 -0700
Message-ID: <4A3954AD.8000305@zytor.com>
References: <20090613230842.GA18347@gallifrey> <4A349B67.1070603@zytor.com> <20090614122734.GA1499@gallifrey> <alpine.LRH.2.00.0906161126330.31685@twin.jikos.cz> <20090617193442.GA31944@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761389AbZFQUkf@vger.kernel.org>
In-Reply-To: <20090617193442.GA31944@gallifrey>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dr. David Alan Gilbert wrote:
> 
> Please find below the new dmesg created by appending i8042.debug; this was
> taken from a slightly newer build of the same source kernel that I reported; this
> build just had a few more things configured out (parallel port) but exhibits
> the same symptom.
> 
> No more debug is generated as I press any keys.
> 

What happens with the mouse?

	-hpa
