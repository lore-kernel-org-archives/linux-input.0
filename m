From: Joao Paulo Rechi Vita <jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE HIDP)
Date: Fri, 16 Mar 2012 14:50:16 -0300
Message-ID: <CAAngNMYSNPX8veuBD2jrvhHSV2v_8e4qRt8ZjYDPcF=-Q8XUCQ@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331909617-22106-1-git-send-email-dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vijaykumar.Dadmode-kQvG35nSl+M@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello David,

On Fri, Mar 16, 2012 at 11:53 AM, David Herrmann
<dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Hi
>
> I have hacked together a small driver which allows user-space I/O dri=
vers to
> provide HID devices. This is needed for Bluetooth-Low-Energy HID devi=
ces as the
> Bluetooth-LE protocol is parsed in user-space.
>
> I have only compile-tested this driver, I haven't run it yet. It's ju=
st an
> proposal how this could be implemented. It should also work as hint t=
o the BT-LE
> developers how such an interface will look-like.
>

=46irst of all, thanks for your effort. I haven't looked at the code
yet, but thinking again about the problem and since it's very similar
to uinput, would adding another ioctl to uinput that receives the HID
descriptor and put uinput in a "HID mode" be sufficient? This way we
could increase code reuse and ease maintainance, I guess. What do you
think?


--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
