From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 1/3] IR: extend ir_raw_event and do refactoring
Date: Sat, 23 Oct 2010 14:13:29 +0200
Message-ID: <20101023121329.GA21845@hardeman.nu>
References: <1287269790-17605-1-git-send-email-maximlevitsky@gmail.com>
 <1287269790-17605-2-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287269790-17605-2-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 17, 2010 at 12:56:28AM +0200, Maxim Levitsky wrote:
> Add new event types for timeout & carrier report
> Move timeout handling from ir_raw_event_store_with_filter to
> ir-lirc-codec, where it is really needed.
> Now lirc bridge ensures proper gap handling.
> Extend lirc bridge for carrier & timeout reports
>=20
> Note: all new ir_raw_event variables now should be initialized
> like that: DEFINE_IR_RAW_EVENT(ev);
>=20
> To clean an existing event, use init_ir_raw_event(&ev);
>=20
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Acked-by: Jarod Wilson <jarod@redhat.com>

I finally had a read-through of this patch. I like it. Note that we're=20
going to have to change the decoders to also use the timeout event=20
(since it basically behaves like a long space and e.g. the NEC decoder=20
waits for the trailing space before sending a keydown). The same proble=
m=20
already exists for users of ir_raw_event_store_with_filter() though so=20
the patch should still go in.

Acked-by: David H=E4rdeman <david@hardeman.nu>
