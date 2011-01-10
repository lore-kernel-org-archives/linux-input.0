From: Alan Ott <alan@signal11.us>
Subject: hidraw: Wait for Ack when Sending to Device
Date: Mon, 10 Jan 2011 15:13:55 -0500
Message-ID: <4D2B6883.7090900@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:56251 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048Ab1AJUN7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 15:13:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id C4F441CCAB86
	for <linux-input@vger.kernel.org>; Mon, 10 Jan 2011 15:13:58 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>, Ville Tervo <ville.tervo@nokia.com>, Jiri Kosina <jkosina@suse.cz>, Bill Good <bgood@velocity.net>, Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>

Hello,

As many of you know, I'm working on getting support for Feature Reports 
into hidraw[1]. The USB side has been done and functional for quite some 
time, but the Bluetooth side has been met with some resistance.

A bit of background on the bluetooth side: Before I got here, hidraw on 
bluetooth only supported sending reports (not requesting them, as is 
done for a feature report). The report would be sent, but 
hidp_output_raw_report() would not wait for an Ack from the device to 
ensure that it got delivered correctly (or reported an error). It was 
kind of fire-and-forget and returned success every time.

To implement request of reports (needed for feature reports), a wait 
queue had to be added, and the receiving thread (hidp_session()) would 
wake up the wait queue when a response had been received[2].

In [2], I left the output function alone (so it only would send data but 
not wait for the ack), but there was an issue reported by Ville Tervo 
that in the case of a failed call to output_raw_report() followed by a 
successful call to get_feature_report(), the get_feature_report() call 
would receive the NAK from the failed output report and would return 
failure (even though the request of the feature report otherwise would 
have succeeded).

To fix this, I changed the output function to have a wait queue and wait 
for an ACK/NAK from the device before returning[3]. I have this working 
for normal devices.

Some HID devices however, (hid-sony.c for one), call 
hid_output_raw_report() (which on a bluetooth HID device will call 
hidp_output_raw_report()) from their respective probe() functions 
(sony_probe() in this case). The problem with this is that 
hidp_session() is not started until _after_ the call to a device's 
probe() function returns. This means that with my new code[3] outputting 
a report from a probe() function on a bluetooth HID device will _never_ 
return success.

In hidp_add_connection() the call to hidp_setup_hid() is what eventually 
calls the device's probe() function. As you can see from the snippet 
below, it's called before the call to kernel_thread() (which creates a 
thread for hidp_session().

        if (req->rd_size > 0) {
                 err = hidp_setup_hid(session, req);
                 if (err && err != -ENODEV)
                         goto purge;
         }

         if (!session->hid) {
                 err = hidp_setup_input(session, req);
                 if (err < 0)
                         goto purge;
         }

         __hidp_link_session(session);

         hidp_set_timer(session);

         err = kernel_thread(hidp_session, session, CLONE_KERNEL);
         if (err < 0)
                 goto unlink;

I'd like to move the call to kernel_thread() above the call to 
setup_hid(). Of course the error handling would have to be shifted a bit 
as well. Does anyone here have a fundamental problem with this?

Alan.

[1] https://lkml.org/lkml/2010/8/16/340
[2] https://lkml.org/lkml/2010/8/16/343
[3] see the inline patch below


diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c

index 0e4880e..b55562a 100644

--- a/net/bluetooth/hidp/core.c

+++ b/net/bluetooth/hidp/core.c

@@ -397,6 +397,9 @@ err_eio:

  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,

          unsigned char report_type)

  {

+    struct hidp_session *session = hid->driver_data;

+    int ret;

+

      switch (report_type) {

      case HID_FEATURE_REPORT:

          report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;

@@ -408,10 +411,59 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s

          return -EINVAL;

      }

  

+    if (mutex_lock_interruptible(&session->report_mutex))

+        return -ERESTARTSYS;

+

+    /* Set up our wait, and send the report request to the device. */

+    set_bit(HIDP_WAITING_FOR_SEND_ACK,&session->flags);

      if (hidp_send_ctrl_message(hid->driver_data, report_type,

-            data, count))

-        return -ENOMEM;

-    return count;

+            data, count)) {

+        ret = -ENOMEM;

+        goto err;

+    }

+

+    {

+        int i;

+        printk(KERN_WARNING "Sent %d message: %02hhx len: %d\n", report_type, data[0], (int)count);

+        for (i = 0; i<  count; i++) {

+            printk(KERN_WARNING " %02hhx", data[i]);

+        }

+        printk(KERN_WARNING "\n");

+    }

+

+    /* Wait for the ACK from the device. */

+    while (test_bit(HIDP_WAITING_FOR_SEND_ACK,&session->flags)) {

+        int res;

+

+        res = wait_event_interruptible_timeout(session->report_queue,

+            !test_bit(HIDP_WAITING_FOR_SEND_ACK,&session->flags),

+            10*HZ);

+        if (res == 0) {

+            /* timeout */

+            printk(KERN_WARNING "TIMEOUT\n");

+            ret = -EIO;

+            goto err;

+        }

+        if (res<  0) {

+            /* signal */

+            printk(KERN_WARNING "SIGNAL\n");

+            ret = -ERESTARTSYS;

+            goto err;

+        }

+    }

+

+    if (!session->output_report_success) {

+        printk(KERN_WARNING "NOT SUCCESS: Returning -EIO\n");

+        ret = -EIO;

+        goto err;

+    }

+

+    ret = count;

+

+err:

+    clear_bit(HIDP_WAITING_FOR_SEND_ACK,&session->flags);

+    mutex_unlock(&session->report_mutex);

+    return ret;

  }

  

  static void hidp_idle_timeout(unsigned long arg)

@@ -438,10 +490,14 @@ static void hidp_process_handshake(struct hidp_session *session,

                      unsigned char param)

  {

      BT_DBG("session %p param 0x%02x", session, param);

+    printk(KERN_WARNING "Handshake Packet %d\n", param);

+    session->output_report_success = 0; /* default condition */

  

      switch (param) {

      case HIDP_HSHK_SUCCESSFUL:

          /* FIXME: Call into SET_ GET_ handlers here */

+        printk(KERN_WARNING "   (Successful)\n");

+        session->output_report_success = 1;

          break;

  

      case HIDP_HSHK_NOT_READY:

@@ -452,6 +508,7 @@ static void hidp_process_handshake(struct hidp_session *session,

              clear_bit(HIDP_WAITING_FOR_RETURN,&session->flags);

              wake_up_interruptible(&session->report_queue);

          }

+        printk(KERN_WARNING "   (not-successful %d)\n", param);

          /* FIXME: Call into SET_ GET_ handlers here */

          break;

  

@@ -470,6 +527,12 @@ static void hidp_process_handshake(struct hidp_session *session,

              HIDP_TRANS_HANDSHAKE | HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0);

          break;

      }

+

+    /* Wake up the waiting thread. */

+    if (test_bit(HIDP_WAITING_FOR_SEND_ACK,&session->flags)) {

+        clear_bit(HIDP_WAITING_FOR_SEND_ACK,&session->flags);

+        wake_up_interruptible(&session->report_queue);

+    }

  }

  

  static void hidp_process_hid_control(struct hidp_session *session,

@@ -494,6 +557,7 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,

  {

      int done_with_skb = 1;

      BT_DBG("session %p skb %p len %d param 0x%02x", session, skb, skb->len, param);

+    printk(KERN_WARNING "Got Data packet. param: %d\n", param);

  

      switch (param) {

      case HIDP_DATA_RTYPE_INPUT:

@@ -647,6 +711,7 @@ static int hidp_session(void *arg)

      wait_queue_t ctrl_wait, intr_wait;

  

      BT_DBG("session %p", session);

+    printk(KERN_WARNING "SESSION STARTING\n");

  

      if (session->input) {

          vendor  = session->input->id.vendor;

@@ -665,6 +730,7 @@ static int hidp_session(void *arg)

      init_waitqueue_entry(&intr_wait, current);

      add_wait_queue(sk_sleep(ctrl_sk),&ctrl_wait);

      add_wait_queue(sk_sleep(intr_sk),&intr_wait);

+    printk(KERN_WARNING "session entering main loop\n");

      while (!atomic_read(&session->terminate)) {

          set_current_state(TASK_INTERRUPTIBLE);

  

@@ -673,6 +739,7 @@ static int hidp_session(void *arg)

  

          while ((skb = skb_dequeue(&ctrl_sk->sk_receive_queue))) {

              skb_orphan(skb);

+            printk(KERN_WARNING "Got CTRL Frame\n");

              hidp_recv_ctrl_frame(session, skb);

          }

  

@@ -925,6 +992,7 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,

      int err;

  

      BT_DBG("");

+    printk(KERN_WARNING "HIDP ADD CONNECTION");

  

      if (bacmp(&bt_sk(ctrl_sock->sk)->src,&bt_sk(intr_sock->sk)->src) ||

              bacmp(&bt_sk(ctrl_sock->sk)->dst,&bt_sk(intr_sock->sk)->dst))

diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h

index 00e71dd..2f16eea 100644

--- a/net/bluetooth/hidp/hidp.h

+++ b/net/bluetooth/hidp/hidp.h

@@ -81,6 +81,7 @@

  #define HIDP_BOOT_PROTOCOL_MODE        1

  #define HIDP_BLUETOOTH_VENDOR_ID    9

  #define    HIDP_WAITING_FOR_RETURN        10

+#define HIDP_WAITING_FOR_SEND_ACK    11

  

  struct hidp_connadd_req {

      int   ctrl_sock;    // Connected control socket

@@ -161,6 +162,9 @@ struct hidp_session {

      struct mutex report_mutex;

      struct sk_buff *report_return;

      wait_queue_head_t report_queue;

+

+    /* Used in hidp_output_raw_report() */

+    int output_report_success; /* boolean */

  

      /* Report descriptor */

      __u8 *rd_data;



