From: Apostolos Bartziokas <barz621@gmail.com>
Subject: Bug#685360: HID: Fix missing Unifying device issue
Date: Mon, 08 Oct 2012 22:42:09 +0300
Message-ID: <50732C91.20005@gmail.com>
References: <1348222894-6767-1-git-send-email-nlopezcasad@logitech.com> <20120923102318.GA12946@entuzijast.net> <CAE7qMroQOxo7kci7roLbS5HXjpkyhRi=cj1WCoYtAPB328xNQg@mail.gmail.com> <20120927070426.GA27734@entuzijast.net> <20120927185628.GA30949@entuzijast.net> <CAE7qMrrjeMBzfofaY+2O4CAh3OSDaK3fDe_c8Hh8Y2web7kUqQ@mail.gmail.com>
Reply-To: Apostolos Bartziokas <barz621@gmail.com>, 685360@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------050103050904050302000001"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.685360.B685360.134972534030606@bugs.debian.org>
In-Reply-To: <CAE7qMrrjeMBzfofaY+2O4CAh3OSDaK3fDe_c8Hh8Y2web7kUqQ@mail.gmail.com>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Josip Rodin <joy@debbugs.entuzijast.net>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 685360@bugs.debian.org, john.ettedgui@gmail.com, dh.herrmann@googlemail.com
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------050103050904050302000001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nestor hello

Sorry for bringing this up again but i tested the patch now that it 
reached the stable kernels and when i connect it to the rear panel of my 
motherboard i get:

Oct 08 22:11:43 mainland kernel: usb 3-2: >USB disconnect, device number 2
Oct 08 22:12:04 mainland kernel: usb 1-2: >new full-speed USB device 
number 3 using xhci_hcd
Oct 08 22:12:05 mainland kernel: logitech-djreceiver 
0003:046D:C52B.0009: >hiddev0,hidraw2: USB HID v1.11 Device [Logitech 
USB Receiver] on usb-0000:00:14.0-2/input2
Oct 08 22:12:05 mainland kernel: logitech-djreceiver 
0003:046D:C52B.0009: >logi_dj_probe:logi_dj_recv_query_paired_devices 
error:-32
Oct 08 22:12:05 mainland kernel: logitech-djreceiver: probe of 
0003:046D:C52B.0009 failed with error -32
Oct 08 22:13:50 mainland kernel: usb 1-2: >USB disconnect, device number 3
Oct 08 22:13:57 mainland kernel: usb 5-1.6: >new full-speed USB device 
number 3 using ehci_hcd
Oct 08 22:13:58 mainland kernel: logitech-djreceiver 
0003:046D:C52B.000C: >hiddev0,hidraw2: USB HID v1.11 Device [Logitech 
USB Receiver] on usb-0000:00:1a.0-1.6/input2
Oct 08 22:14:01 mainland kernel: input: Logitech Unifying Device. 
Wireless PID:101a as 
/devices/pci0000:00/0000:00:1a.0/usb5/5-1/5-1.6/5-1.6:1.2/0003:046D:C52B.000C/input/input15
Oct 08 22:14:01 mainland kernel: logitech-djdevice 0003:046D:C52B.000D: 
 >input,hidraw3: USB HID v1.11 Mouse [Logitech Unifying Device. Wireless 
PID:101a] on usb-0000:00:1a.0-1.6:1
Oct 08 22:14:17 mainland kernel: usb 5-1.6: >USB disconnect, device number 3
Oct 08 22:14:20 mainland kernel: usb 1-2: >new full-speed USB device 
number 4 using xhci_hcd
Oct 08 22:14:20 mainland kernel: logitech-djreceiver 
0003:046D:C52B.0010: >hiddev0,hidraw2: USB HID v1.11 Device [Logitech 
USB Receiver] on usb-0000:00:14.0-2/input2
Oct 08 22:14:20 mainland kernel: logitech-djreceiver 
0003:046D:C52B.0010: >logi_dj_probe:logi_dj_recv_query_paired_devices 
error:-32
Oct 08 22:14:20 mainland kernel: logitech-djreceiver: probe of 
0003:046D:C52B.0010 failed with error -32

When i use a usb3 port it doesn't move at all and if i use a usb2 port 
its slow. When i use the front panel it works flawlessly. Could this be 
related to my POS Intel motherboard?

Kind regards and apologies if i raise a false alarm.

Apostolos B.
On 09/28/2012 10:57 AM, Nestor Lopez Casado wrote:
> Hello Josip,
>
> This really looks like a different problem from the one addressed with 
> this patch.
>
> I'll try to work on it as soon as I find some time for that.
>
> Thanks,
> Nestor.
>
> On Thu, Sep 27, 2012 at 8:56 PM, Josip Rodin 
> <joy@debbugs.entuzijast.net <mailto:joy@debbugs.entuzijast.net>> wrote:
>
>     On Thu, Sep 27, 2012 at 09:04:26AM +0200, Josip Rodin wrote:
>     > On Mon, Sep 24, 2012 at 11:30:28AM +0200, Nestor Lopez Casado wrote:
>     > > Josip, this is a different issue from the one addressed with
>     the patch.
>     > >
>     > > 1) Can you try it on a 3.2 kernel ?
>     >
>     > I can try that too, I'll let you know how it went.
>
>     Same thing, it doesn't work.
>
>     --
>          2. That which causes joy or happiness.
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-input" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


--------------050103050904050302000001
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Nestor hello<br>
    <br>
    Sorry for bringing this up again but i tested the patch now that it
    reached the stable kernels and when i connect it to the rear panel
    of my motherboard i get:<br>
    <br>
    <small>Oct 08 22:11:43 mainland kernel: usb 3-2: &gt;USB disconnect,
      device number 2<br>
      Oct 08 22:12:04 mainland kernel: usb 1-2: &gt;new full-speed USB
      device number 3 using xhci_hcd<br>
      Oct 08 22:12:05 mainland kernel: logitech-djreceiver
      0003:046D:C52B.0009: &gt;hiddev0,hidraw2: USB HID v1.11 Device
      [Logitech USB Receiver] on usb-0000:00:14.0-2/input2<br>
      Oct 08 22:12:05 mainland kernel: logitech-djreceiver
      0003:046D:C52B.0009:
      &gt;logi_dj_probe:logi_dj_recv_query_paired_devices error:-32<br>
      Oct 08 22:12:05 mainland kernel: logitech-djreceiver: probe of
      0003:046D:C52B.0009 failed with error -32<br>
      Oct 08 22:13:50 mainland kernel: usb 1-2: &gt;USB disconnect,
      device number 3<br>
      Oct 08 22:13:57 mainland kernel: usb 5-1.6: &gt;new full-speed USB
      device number 3 using ehci_hcd<br>
      Oct 08 22:13:58 mainland kernel: logitech-djreceiver
      0003:046D:C52B.000C: &gt;hiddev0,hidraw2: USB HID v1.11 Device
      [Logitech USB Receiver] on usb-0000:00:1a.0-1.6/input2<br>
      Oct 08 22:14:01 mainland kernel: input: Logitech Unifying Device.
      Wireless PID:101a as
/devices/pci0000:00/0000:00:1a.0/usb5/5-1/5-1.6/5-1.6:1.2/0003:046D:C52B.000C/input/input15<br>
      Oct 08 22:14:01 mainland kernel: logitech-djdevice
      0003:046D:C52B.000D: &gt;input,hidraw3: USB HID v1.11 Mouse
      [Logitech Unifying Device. Wireless PID:101a] on
      usb-0000:00:1a.0-1.6:1<br>
      Oct 08 22:14:17 mainland kernel: usb 5-1.6: &gt;USB disconnect,
      device number 3<br>
      Oct 08 22:14:20 mainland kernel: usb 1-2: &gt;new full-speed USB
      device number 4 using xhci_hcd<br>
      Oct 08 22:14:20 mainland kernel: logitech-djreceiver
      0003:046D:C52B.0010: &gt;hiddev0,hidraw2: USB HID v1.11 Device
      [Logitech USB Receiver] on usb-0000:00:14.0-2/input2<br>
      Oct 08 22:14:20 mainland kernel: logitech-djreceiver
      0003:046D:C52B.0010:
      &gt;logi_dj_probe:logi_dj_recv_query_paired_devices error:-32<br>
      Oct 08 22:14:20 mainland kernel: logitech-djreceiver: probe of
      0003:046D:C52B.0010 failed with error -32</small><br>
    <br>
    When i use a usb3 port it doesn't move at all and if i use a usb2
    port its slow. When i use the front panel it works flawlessly. Could
    this be related to my POS Intel motherboard? <br>
    <br>
    Kind regards and apologies if i raise a false alarm.<br>
    &nbsp;<br>
    Apostolos B.<br>
    <div class="moz-cite-prefix">On 09/28/2012 10:57 AM, Nestor Lopez
      Casado wrote:<br>
    </div>
    <blockquote
cite="mid:CAE7qMrrjeMBzfofaY+2O4CAh3OSDaK3fDe_c8Hh8Y2web7kUqQ@mail.gmail.com"
      type="cite">Hello Josip,&nbsp;
      <div><br>
      </div>
      <div>This really looks like a different problem from the one
        addressed with this patch.&nbsp;</div>
      <div><br>
      </div>
      <div>I'll try to work on it as soon as I find some time for that.&nbsp;</div>
      <div><br>
      </div>
      <div>Thanks,&nbsp;</div>
      <div>Nestor.&nbsp;<br>
        <br>
        <div class="gmail_quote">On Thu, Sep 27, 2012 at 8:56 PM, Josip
          Rodin <span dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:joy@debbugs.entuzijast.net" target="_blank">joy@debbugs.entuzijast.net</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div class="im">On Thu, Sep 27, 2012 at 09:04:26AM +0200,
              Josip Rodin wrote:<br>
              &gt; On Mon, Sep 24, 2012 at 11:30:28AM +0200, Nestor
              Lopez Casado wrote:<br>
              &gt; &gt; Josip, this is a different issue from the one
              addressed with the patch.<br>
              &gt; &gt;<br>
              &gt; &gt; 1) Can you try it on a 3.2 kernel ?<br>
              &gt;<br>
              &gt; I can try that too, I'll let you know how it went.<br>
              <br>
            </div>
            Same thing, it doesn't work.<br>
            <div class="HOEnZb">
              <div class="h5"><br>
                --<br>
                &nbsp; &nbsp; &nbsp;2. That which causes joy or happiness.<br>
                --<br>
                To unsubscribe from this list: send the line
                "unsubscribe linux-input" in<br>
                the body of a message to <a moz-do-not-send="true"
                  href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a><br>
                More majordomo info at &nbsp;<a moz-do-not-send="true"
                  href="http://vger.kernel.org/majordomo-info.html"
                  target="_blank">http://vger.kernel.org/majordomo-info.html</a><br>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------050103050904050302000001--
